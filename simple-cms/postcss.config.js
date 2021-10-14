module.exports = {
  plugins: [
    require("postcss-import")({ path: ["./app/frontend"] }),
    require("postcss-flexbugs-fixes"),
    require("tailwindcss")({ config: "./app/frontend/tailwind.js" }),
    require("autoprefixer"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
  ],
};
