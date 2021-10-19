module.exports = {
  plugins: [
    require("postcss-import")({ path: ["./app/frontend"] }),
    require("postcss-flexbugs-fixes"),

    // For some reason I couldn't get the require("tailwindcss")("./app/frontend/tailwind.js") to work,
    // but when I switched to the object notation it worked.
    require("tailwindcss")({ config: "./app/frontend/tailwind.js" }),
    require("postcss-nested"),
    require("autoprefixer"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
  ],
};
