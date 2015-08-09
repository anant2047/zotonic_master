{% extends "logon.tpl" %}
{% block content_area %}

<div id="otp_form">
  
        {% wire id="otp_form1" type="submit" postback="otp_form_verified" delegate="controller_logon" %}
        <form id="otp_form1" method="post" action="postback">

        <h1 class="logon_header">{_ OTP has been sent to you _}</h1>

            <input type="hidden" id="otp_form2" name="secret" value="{{ secret|escape }}" />
             <input type="hidden" id="UserId" name="UserId" value="{{ q.UserId }}" />
            <div class="form-group">
            <label class="control-label" for="otp1">{_ Below you can enter OTP _}</label>
                <div>
                <input type="password" id="otp1" class="col-lg-4 col-md-4 form-control" name="otp1" value="" autocomplete="off" />
                </div>
            </div>
            <div class="form-group buttons">
                <div>
                <button class="btn btn-primary btn-lg" type="submit">{_ Submit OTP_}</button>
                </div>

            </div>


     {% javascript %}setTimeout(function(){$("#otp1").focus(); z_init_postback_forms();}, 100);{% endjavascript %}
    </form>
</div>
{% endblock %}
