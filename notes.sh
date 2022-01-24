#!/usr/bin/env bash
 
# $1: Bilde-fil/mappe med bilde-filer
# $2: Resultat-format (overlay/montage, se funksjoner som starter på `t:`)
 
# Dette scriptet legger på et ImageMagick filter over bilder for å gjøre teksten på displayene lettere å lese.
# For å endre filter og farge, endre variablene `blend` og `colour`.
# For å se de forskjellige filtrene, kjør scriptet med `montage` som andre-argument (hvor argument 1 er et bilde, en hel mappe vil ta lang tid).
# Om du oppgir en mappe vil den gå gjennom alle bilde-filer som starter med mr*, basert på strukturen i root@nginx01.prd.int.trd.kantega.org:/var/www/dash.
 
# Eskempelbruk:
#  $ scp -r root@nginx01.prd.int.trd.kantega.org:/var/www/dash .
#  $ cd dash
#  # Legg dette scriptet i dash mappen -> $ chmod +x tint-images.sh
#  $ ./tint-images.sh .
#  $ scp -r *blend.jpg root@nginx01.prd.int.trd.kantega.org:/var/www/dash
 
# scp -r root@nginx01.prd.int.trd.kantega.org:/var/www/dash .
# scp -r *blend.jpg root@nginx01.prd.int.trd.kantega.org:/var/www/dash
 
set -o errexit
remove_leftovers () {
  for i in "${@}"; do
    printf "rm -f ${i}\n"
    rm -f "${i}"
  done
}
 
transform () {
  # Blends can be found by running `transform "image.jpg" t:montage`, SrcAtop generally looks good.
  blend="SrcAtop"
  colour="3e558055"
 
  image="$(basename -- "${1:?}")" # mrtturing.jpg
  transformation="${2:?}" # a function to apply to the image, t:montage, t:overlay
  image_basename="${image%.*}" # mrtturing
  image_extension="${image##*.}" # jpg
  image_overlay="${image_basename}-overlay.png" # mrtturing-overlay.png
  image_blend="${image_basename}-blend.${image_extension}" # mrtturing-blend.jpg
  printf "\nImage: ${image}\nBasename: ${image_basename}\nExtension: ${image_extension}\n"
 
  rm -f "${image_overlay}" "${image_blend}"
 
  image_size="$(identify -format "%[fx:w]x%[fx:h]" "${image}")"
  # Resize image if "too big" for montage? https://stackoverflow.com/a/15987280
  convert -size "${image_size}" "xc:#${colour}" "${image_overlay}"
  printf "Size: ${image_size}\n"
  trap "remove_leftovers ${image_overlay}" EXIT
  trap "remove_leftovers ${image_overlay} ${image_blend}" SIGINT
 
  "${transformation}" "${image}"
 
  #xdg-open "${image_blend}" &
  #sleep 0.5
 
  rm -f "${image_overlay}"
}
 
t:overlay () {
  convert "${image}" "${image_overlay}" -compose "${blend}" -composite "${image_blend}"
}
 
t:montage () {
  for blend in $(identify -list compose | grep -v Blur); do
    convert -label "${blend}" "${image}" "${image_overlay}" -compose "${blend}" -composite miff:-
  done | montage - -tile 5x "${image_blend}"
}
 
#transform "./mrtturing.jpg" t:montage; exit
 
target="${1:-.}"
strategy="${2:-overlay}" # overlay, montage
if test -f "${target}"; then
  transform "${target}" "t:${strategy}"
elif test -d "${target}"; then
  find "${target}" \( -not -iname "*blend*" -not -iname "*overlay*" -iname "mr*.jp*g" -o -iname "mr*.png" \) -print0 \
    | while read -r -d $'\0' file; do
    transform "${file}" "t:${strategy}"
  done
fi
