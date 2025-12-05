FROM node:22-alpine AS base
RUN corepack enable
WORKDIR /app

FROM base AS deps

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

FROM base AS build

COPY --from=deps /app/node_modules ./node_modules
COPY . . 

RUN pnpm run build

FROM base AS runtime
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./package.json
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/public ./public

USER appuser

EXPOSE 4173

CMD ["pnpm", "preview", "--host", "0.0.0.0"]
