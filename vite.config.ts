import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: [["babel-plugin-react-compiler"]],
      },
    }),
  ],
  preview: {
    host: true,
    port: 4173,
    allowedHosts: ["ec2-34-237-51-39.compute-1.amazonaws.com"],
  },
});
