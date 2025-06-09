// static/js/main.js
window.loadStylesheets = function () {
    const stylesheets = [
      "/static/css/style.css",
      "/static/css/components/login.css"
      ,
    ];
    stylesheets.forEach((url) => {
      if (!document.querySelector(`link[href="${url}"]`)) {
        const link = document.createElement("link");
        link.rel = "stylesheet";
        link.href = url;
        document.head.appendChild(link);
        console.log(`Loaded stylesheet: ${url}`);
      }
    });
  };

  console.log("main.js loaded");
