{% extends "logon.tpl" %}
{% block content_area %}

<div id="submit_mobile_number">
    {% debug %}
    <p> {{ UserId }} </p>
        {% wire id="submit_mobile_number1" type="submit" postback="mobile_number_submitted" delegate="controller_logon_using_mobile" %}
        <form id="submit_mobile_number1" method="post" action="postback">

        <h1 class="logon_header">{_ Mobile number Submit form _}</h1>

            <input type="hidden" id="submit_mobile_number2" name="secret" value="{{ secret|escape }}" />
             <input type="hidden" id="UserId" name="UserId" value="{{ q.UserId }}" />
            <div class="form-group">
	    <p>Instead of entering number again and again you can go to "/admin" than click on auth than users and press the edit button 	     there you will find a form to submit your mobile number </p>
            <label class="control-label" for="mobile_number">{_ Please enter your mobile phone number in the below box _}</label>
                <div>
                <input type="password" id="mobile_number" class="col-lg-4 col-md-4 form-control" name="mobile_number" value="" 		   autocomplete="off" />
                </div>
            </div>
            <div class="form-group buttons">
                <div>
                <button class="btn btn-primary btn-lg" type="submit">{_ Submit _}</button>
                </div>

            </div>


     {% javascript %}setTimeout(function(){$("#otp1").focus(); z_init_postback_forms();}, 100);{% endjavascript %}
    </form>
</div>
{% endblock %}

