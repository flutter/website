document.addEventListener('DOMContentLoaded', () => {
    const daysContainer = document.querySelector('.days-digits_container');
    const hoursContainer = document.querySelector('.hours-digits_container');
    const minutesContainer = document.querySelector('.minutes-digits_container');
    const secondsContainer = document.querySelector('.seconds-digits_container');
    const eventTime = new Date(Date.UTC(2019, 10, 18, 17, 0, 0));

    let interval;

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
            daysContainer.innerText = '00';
            hoursContainer.innerText = '00';
            minutesContainer.innerText = '00';
            secondsContainer.innerText = '00';
            clearInterval(interval);
        }
    }

    setTimer();
    interval = setInterval(setTimer, 1000);
});
