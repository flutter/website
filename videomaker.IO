<!DOCTYPE html>
<html>
  <head>
    <title>Video Generator</title>
  </head>
  <body>
    <button id="generate-video">Generate Video</button>
    <div id="video-container"></div>
    <script>
      const generateVideoButton = document.querySelector('#generate-video');
      const videoContainer = document.querySelector('#video-container');
      
      generateVideoButton.addEventListener('click', () => {
        fetch('https://example.com/api/video-generator?text=hello%20world')
          .then(response => response.json())
          .then(data => {
            // Create the video element and set its attributes
            const videoElement = document.createElement('video');
            videoElement.src = data.videoUrl;
            videoElement.controls = true;
            
            // Add the video element to the video container
            videoContainer.appendChild(videoElement);
          })
          .catch(error => {
            console.error('Error generating video:', error);
          });
      });
    </script>
  </body>
</html>
