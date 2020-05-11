new gweb.analytics.AutoTrack({
    profile: 'UA-5436354-2'
});

var subscribePreferencesData = {
    'fields': {
        'EmailAddress': {
            'error_messages': {
                'invalid': '',
                'required': 'Required'
            },
            'field_type': 'Email',
            'label': 'Email Address',
            'required': true
        },
        'ExperienceLevel': {
            'choices': [
                [
                    'Novice',
                    'Novice'
                ],
                [
                    'Intermediate',
                    'Intermediate'
                ],
                [
                    'Advanced',
                    'Advanced'
                ]
            ],
            'error_messages': {
                'invalid_choice': 'Select a valid choice. %(value)s is not one of the available choices.',
                'required': 'This field is required.'
            },
            'field_type': 'Choice',
            'label': 'Flutter experience level',
            'required': false
        }
    },
    'google_analytics_account': 'UA-5436354-2',
    'url': 'https://services.google.com/fb/submissions/flutterpreferences/'
};

var emailAddressEl = document.querySelector('#email-address')
var experienceLevelEl = document.querySelector('#experience-level');
var submitEl = document.querySelector('#submit-btn');

// Set up the experience level <select> element.
var exps = subscribePreferencesData.fields.ExperienceLevel.choices;
for (var idx in exps) {
    var e = exps[idx];
    experienceLevelEl.appendChild(new Option(e[1], e[0]));
}

submitEl.addEventListener("click", submitForm);

function submitForm() {
    var data = {};

    if (emailAddressEl.value) {
        data.EmailAddress = emailAddressEl.value;
    }


    if (experienceLevelEl.value) {
        data.ExperienceLevel = experienceLevelEl.value;
    }

    sendRequest(data);

}

function sendRequest(data) {
    jQuery.ajax({
        url: subscribePreferencesData.url,
        type: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
        },
        contentType: "application/x-www-form-urlencoded",
        data: data,
    })
        .done(function (data, textStatus, jqXHR) {
            if (jqXHR.status != 200) {
                throw "Unexpected HTTP status code: " + jqXHR.status;
            }
            if (data.result == "invalid" && data.errors) {
                showErrors(data.errors);
            } else {
                location.href = "/subscribe/subscribed.html";
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("HTTP Request Failed");
        })
        .always(function () {
        });
}

function showErrors(errors) {
    let container = $("#error-container");
    container.empty();

    for (let formElementName in errors) {
        let errorName = errors[formElementName];
        if (errorName.length > 0 && errorName[0] == "Required") {
            console.log();
            let messageEl = document.createElement("p");

            // Limit the length of the field label name used in the error message
            let humanReadableName = subscribePreferencesData.fields[formElementName].label.substring(0, 23);

            messageEl.textContent = humanReadableName + " is required";
            container.append(messageEl);
        }
    }
}
