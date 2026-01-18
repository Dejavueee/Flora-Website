$(document).ready(function () {
    var $owl = $('.main-slider-two__carousel');

    // Function to handle video state
    function checkVideo() {
        var $activeItem = $('.owl-item.active');
        var $video = $activeItem.find('video');

        if ($video.length) {
            // Video found
            var videoElement = $video[0];

            // Stop carousel autoplay
            $owl.trigger('stop.owl.autoplay');

            // Play video
            videoElement.play();

            // When video ends
            videoElement.onended = function () {
                // Go to next slide
                $owl.trigger('next.owl.carousel');
                // Resume autoplay (it will pick up the default timeout for the next slide)
                $owl.trigger('play.owl.autoplay');
            };
        } else {
            // No video, ensure autoplay is running
            $owl.trigger('play.owl.autoplay');
        }
    }

    // Initialize checking on load (for the first slide)
    // We attach to 'initialized' but since it might be too late, we also call it manually if owl is already there, 
    // or just rely on the fact that existing scripts init it.
    // However, Owl might already be running. Let's hook into events.

    // Check whenever the slide changes
    $owl.on('translated.owl.carousel', function (event) {
        checkVideo();
    });

    // Also check on initialization if possible, or just run it once after a short delay to ensure everything is loaded,
    // though the main script initializes owl on window load.

    // Since alefox.js initializes owl on window.load, we should wait for that or just hook properly.
    // The reliable way is to check the first active item roughly when we start.

    // Let's hook once valid.
    checkVideo();

    // In case this script loads before the carousel is initialized by the main script (which is on window.load),
    // we might need to wait.
    $(window).on('load', function () {
        // Allow a slight delay for Owl to init
        setTimeout(function () {
            checkVideo();
        }, 100);
    });
});
