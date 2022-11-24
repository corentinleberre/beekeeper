# Stage 1 : Build the project
FROM node:16-alpine as builder

ENV NODE_ENV build

WORKDIR /home/node/beekeeper

COPY --chown=node:node . .
RUN npm ci && \
    npm run build &&  \
    npm prune --production

# Stage 2 : Minify the docker image
FROM node:16-alpine as minified

ENV NODE_ENV production

WORKDIR /home/node/beekeeper

COPY --from=builder --chown=node:node /home/node/beekeeper/package*.json ./
COPY --from=builder --chown=node:node /home/node/beekeeper/node_modules/ ./node_modules/
COPY --from=builder --chown=node:node /home/node/beekeeper/dist/ ./dist/

CMD ["npm", "run", "start"]