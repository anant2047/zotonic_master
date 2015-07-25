{% extends "logon.tpl" %}
{% block content_area %}

<div id="otp_form_error">
        <h1 class="logon_header">{_ You entered an unknown OTP.  Please try again. _}</h1>
            <div class="form-group">
            <label class="control-label" for="otp1">{_ You can directly copy the OTP from the message sent to you. _}</label>
            <p><a class="btn btn-default" href="{% url logon %}">{_ Back to logon form _}</a></p>
        </div>
</div>
{% endblock %}