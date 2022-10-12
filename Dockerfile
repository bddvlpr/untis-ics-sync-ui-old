FROM node:18 AS build-env
WORKDIR /app

COPY package.json .
COPY yarn.lock .
COPY tsconfig.json .
RUN yarn install --frozen-lockfile --network-timeout 100000

COPY . .
RUN yarn build

FROM node:18 AS runtime-env
WORKDIR /app

COPY --from=build-env /app/build/ .
COPY --from=build-env /app/node_modules/ ./node_modules/
COPY --from=build-env /app/package.json .

HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=3 CMD curl --fail http://localhost:3000/ || exit 1
EXPOSE 3000
CMD ["node", "index.js"]