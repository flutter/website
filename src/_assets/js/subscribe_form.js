(function() {
    // Form elements
    const subscribeContainer = document.querySelector('.subscribe-container');
    const successMessage = document.querySelector('.success-message');
    // Select form elements directly from the subscribeContainer to avoid pass through the entire document
    const subscribeForm = subscribeContainer.querySelector('.subscribe-container__form');
    const errorMessage = subscribeContainer.querySelector('.error-message');
    const formSubmitButton = subscribeContainer.querySelector('.form-submit-button');
    const countrySelect = subscribeContainer.querySelector('.subscribe-country_select');
    const subscribeCheckbox = subscribeContainer.querySelector('.subscribe-checkbox');
    const requiredFields = Array.from(subscribeForm.querySelectorAll("[required]"));

    // List of countries that need a reconfirmation email
    const unconfirmedCountries = ['AT: Austria', 'DE: Germany', 'GR: Greece', 'LU: Luxembourg', 'NO: Norway'];

    // Add change eventListener to required fields
    for (let item of requiredFields) {
        item.addEventListener('change', submitButtonHandler);
    }

    // Check request after clicking the submit button
    formSubmitButton.addEventListener('click',  submitForm);

    //  Create an XMLHttpRequest to get formbox response
    function submitForm() {
        const request = new XMLHttpRequest();

        request.onreadystatechange = () => {
            // readyState 4 means that the operation is complete.
            if (request.readyState === 4) {
                if (request.status === 200) {
                    successHandler(request);
                } else {
                    errorHandler();
                }
            }
        };

        request.open('post', subscribeForm.action);
        if (request) {
            request.send(new FormData(subscribeForm));
        }
    }

    // Show error/success message given the response
    function successHandler(request) {
        const response = request.response ? JSON.parse(request.response).result : null;
        const errorMessageClass = errorMessage.classList;

        if (response === 'accepted') {
            subscribeContainer.classList.add('d-none');
            subscribeForm.classList.add('d-none');
            successMessage.classList.add('d-block');
            errorMessageClass.remove('d-block');
        } else {
            errorHandler();
        }
    }

    // Show errormessage when there is an error in the server response
    function errorHandler() {
        errorMessage.classList.add('d-block');
    }

    // Validation made when required inputs change
    function submitButtonHandler () {
        const submitButtonClass = formSubmitButton.classList;

        if (subscribeForm.reportValidity()) {
            submitButtonClass.add('btn-primary');
            submitButtonClass.remove('form-submit-button__disabled');
            formSubmitButton.disabled = false;
        } else if (submitButtonClass.contains('btn-primary')) {
            submitButtonClass.remove('btn-primary');
            submitButtonClass.add('form-submit-button__disabled');
            formSubmitButton.disabled = true;
        }

        // Change sign me up value to 'unconfirmed' it country selected needs a reconfirmation email.
        if (unconfirmedCountries.includes(countrySelect.value)) {
            subscribeCheckbox.value = "UNCONFIRMED";
        }
    }
}());
