z{% extends "logon.tpl" %}
{% block content_area %}

<div id="mobile_number_not_found">
    {% debug %}
    <p> {{ UserId }} </p>
        {% wire id="mobile_number_not_found1" type="submit" postback="mobile_number_not_found" delegate="controller_logon" %}
        <form id="mobile_number_not_found1" method="post" action="postback">

        <h1 class="logon_header">{_ Mobile number not found in database _}</h1>

            <div class="form-group">

                <p>Your number is not present in the database,therefore,you cannot use multi-factor authentication via mobile phone.
                We have deactivated the module corresponding to multi-factor authetication via moble phone you can directly login by 			entering correct username password. </p>
                <p>To enable this module you can go to "/admin" than click on auth, than users and there press the edit button there you 			will find a form to submit your mobile number </p>

                <label class="control-label" for="mobile_number">{_ Click on the below link to go back to logon form _}</label>
            </div>
            <div class="form-group buttons">
                <div>
                <button class="btn btn-primary btn-lg" type="submit">{_ Back to logon form _}</button>
                </div>

            </div>


     {% javascript %}setTimeout(function(){$("#otp1").focus(); z_init_postback_forms();}, 100);{% endjavascript %}
    </form>
</div>
{% endblock %}
