/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      flex: {
        '1.2': '1.2 1.2 0%',
        '1.3': '1.3 1.3 0%',
        '1.5': '1.5 1.5 0%',
        '2': '2 2 0%',
        '3': '3 3 0%'
      },
      colors: {
        'main-blue': '#119AE2',
        'flashsale': '#E03E3E',
        'flash-bg': '',
        'heading-black': '#222222',
        'gray': "#F3F3F3",
        'green': "#08AF37",
        'gray-2': "#B2B3B4",
      },
      boxShadow: {
        sdprimary: "0px 5px 22px rgba(0, 0, 0, 0.04)",
      },
      width: {
        content: "1200px",
      },
      backgroundImage: {
        "5-star-service": "url('assets/images/5-star-service.png')",
      },
    },
  },
  plugins: [],
};
