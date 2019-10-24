(function () {
    const daysContainer = document.querySelector('.days-digits_container');
    const hoursContainer = document.querySelector('.hours-digits_container');
    const minutesContainer = document.querySelector('.minutes-digits_container');
    const secondsContainer = document.querySelector('.seconds-digits_container');
    const eventTime = 'December 21 2019 17:30:00'; // TODO: Actual event day TBD

    // Returns remaining time in days, hours, minutes and seconds.
    function getTimeRemaining() {
        const t = Date.parse(eventTime) - Date.parse(new Date());
        const seconds = Math.floor( (t/1000) % 60 );
        const minutes = Math.floor( (t/1000/60) % 60 );
        const hours = Math.floor( (t/(1000*60*60)) % 24 );
        const days = Math.floor( t/(1000*60*60*24) );
        return  {
            'total': t,
            'days': days,
            'hours': hours,
            'minutes': minutes,
            'seconds': seconds,
        };
    }

    // Adds a zero number if there's just one digit
    function digitsHandler(number) {
        return number > 9 ? number : `0${number}`;
    }

    function setTimer() {
        const remainingTime = getTimeRemaining();

        if (remainingTime.total > 0) {
            const days = digitsHandler(remainingTime.days);
            const hours = digitsHandler(remainingTime.hours);
            const minutes = digitsHandler(remainingTime.minutes);
            const seconds = digitsHandler(remainingTime.seconds);

            daysContainer.innerText = `${days}`;
            hoursContainer.innerText = `${hours}`;
            minutesContainer.innerText = `${minutes}`;
            secondsContainer.innerText = `${seconds}`;
        } else {
            console.log('The event is now');
            clearInterval();
        }
    }

    setTimer();
    setInterval(setTimer, 1000);
}());
