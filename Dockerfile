FROM bretfisher/jekyll-serve

RUN apk add --no-cache nodejs npm

COPY ./ /site

RUN rm -rf /site/_site/* /site/.jekyll-cache/*