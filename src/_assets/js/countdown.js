const timeNumber = document.querySelector('.time-number');
const eventTime = moment('21-12-2019 17:30:00', 'DD-MM-YYYY HH:mm:ss');

function setTimer() {
    const currentTime = moment();
    const diffTime = eventTime - currentTime;

    function digitsHandler(number) {
        return number > 9 ? number : `0${number}`;
    }

    if (diffTime > 0) {
        // Duration left to the event
        const duration = moment.duration(eventTime.diff(currentTime));

        //Get Days
        const days = digitsHandler(duration.days());

        //Get hours
        const hours = digitsHandler(duration.hours());

        //Get Minutes
        const minutes = digitsHandler(duration.minutes());

        //Get seconds
        const seconds = digitsHandler(duration.seconds());

        timeNumber.innerText = `${days}:${hours}:${minutes}:${seconds}`;
    } else {
        timeNumber.innerText = "The event is right now";
        clearInterval();
    }
}

(function () {
    setTimer();
    setInterval(setTimer, 1000);
}());
