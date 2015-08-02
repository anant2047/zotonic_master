{% extends "email_base.tpl" %}

{% block title %}{_ Verify your account _}{% endblock %}

{% block body %}
<p>{_ Hello _} {{ m.rsc[id].name_first|default:m.rsc[id].title }},</p>
<p>{_ Your Mobile number is _} {{ m.rsc[id].phone_mobile|default:m.rsc[id].title }},</p>


{% all include "_logon_extra_email_reset.tpl" identity_types=m.identity[id].all_types %}

<p>{_ OTP for login is _}"<strong>{{ otp|default:(m.rsc[id].otp)|escape }}</strong>"</p>


<p>{_ If you didn't login, you account might have been compromised. _}</p>
{% endblock %}

{% block disclaimer %}
<p style="color: #666; font-size: 80%;">--<br/>
{_ You have recieved this email because you have turned on Multi-Factor-Authentication. This will protect your account from getting hacked. _}</p>
{% endblock %}
