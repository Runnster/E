<!DOCTYPE html>
<html lang="en-us">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>Run3Editor</title>
<style>
      html {
        box-sizing: border-box;
      }
      *, *:before, *:after {
        box-sizing: inherit;
      }
      body {
        margin: 0;
        background: #444;
      }
      #gameContainer {
        width: 100vw;
        height: 100vh;
      }
      canvas {
        width: 100%;
        height: 100%;
        display: block;
      }
      /* try to handle mobile dialog */
      canvas + * {
        z-index: 2;
      }
      .logo {
          display: block;
          max-width: 100vw;
          max-height: 70vh;
      }

      .progress {
          margin: 1.5em;
          border: 1px solid white;
          width: 50vw;
          display: none;
      }
      .progress .full {
          margin: 2px;
          background: white;
          height: 1em;
          transform-origin: top left;
      }

      #loader {
        position: absolute;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        background-color:black;
      }

      .spinner,
      .spinner:after {
        border-radius: 50%;
        width: 5em;
        height: 5em;
      }
      .spinner {
        margin: 10px;
        font-size: 10px;
        position: relative;
        text-indent: -9999em;
        border-top: 1.1em solid rgba(255, 255, 255, 0.2);
        border-right: 1.1em solid rgba(255, 255, 255, 0.2);
        border-bottom: 1.1em solid rgba(255, 255, 255, 0.2);
        border-left: 1.1em solid #ffffff;
        transform: translateZ(0);
        animation: spinner-spin 1.1s infinite linear;
      }
      @keyframes spinner-spin {
        0% {
          transform: rotate(0deg);
        }
        100% {
          transform: rotate(360deg);
        }
      }

    </style>
</head>
<body>
<div id="gameContainer"></div>
<div id="loader">
<img class="logo" src="loading.png?v=1">
<div class="spinner"></div>
<div class="progress"><div class="full"></div></div>
</div>
</body>
<script src="Build/UnityLoader.js"></script>
<script>
  var gameInstance = UnityLoader.instantiate("gameContainer", "Build/ThuongRun3.json", {onProgress: UnityProgress});
  function UnityProgress(gameInstance, progress) {
    if (!gameInstance.Module) {
      return;
    }
    const loader = document.querySelector("#loader");
    if (!gameInstance.progress) {
      const progress = document.querySelector("#loader .progress");
      progress.style.display = "block";
      gameInstance.progress = progress.querySelector(".full");
      loader.querySelector(".spinner").style.display = "none";
    }
    gameInstance.progress.style.transform = `scaleX(${progress})`;
    if (progress === 1 && !gameInstance.removeTimeout) {
      gameInstance.removeTimeout = setTimeout(function() {
          loader.style.display = "none";
      }, 2000);
    }
  }
  </script>
</html>
