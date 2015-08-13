{% extends "logon.tpl" %}
{% block content_area %}

<div id="otp_form_error" style="background-color:#F1EEEE;margin-left:auto;margin-right:auto;display:block;margin-top:10%;margin-bottom:10%;width: 500px">
        <h1 class="control-label form-field-error"><font size="6">{_ You entered unknown an OTP. Please try again. _}</font></h1>
            <div class="form-group">
            <label class="control-label form-field-error" for="otp1">{_ You can directly copy the OTP from the message sent to you. _}</label>
            <p><a class="btn btn-default" href="{% url logon %}">{_ Back to logon form _}</a></p>
        </div>
</div>
{% endblock %}
