FROM node:6.9.2
EXPOSE 8085
COPY server.js .
CMD node server.js
