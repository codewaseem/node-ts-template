FROM node:14-alpine as base
RUN apk add --no-cache libc6-compat

FROM base as deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install

FROM base as builder
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN yarn compile && npm prune --production

FROM node:14-alpine as runner
ENV NODE_ENV=production

WORKDIR /app
COPY package.json yarn.lock ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD ["node", "dist/index"]

