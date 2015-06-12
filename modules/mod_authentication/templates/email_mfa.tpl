{% extends "email_base.tpl" %}

{% block title %}{_ Verify your account _}{% endblock %}

{% block body %}
<p>{_ Hello _} {{ m.rsc[id].name_first|default:m.rsc[id].title }},</p>

<p>{_ Your account name is _} “<strong>{{ m.identity[id].username|escape }}</strong>”.{% if m.identity[id].username != email|default:(m.rsc[id].email) %} {_ The e-mail address associated with your account is _} “<strong>{{ email|default:(m.rsc[id].email)|escape }}</strong>”.{% endif %}</p>

{% all include "_logon_extra_email_reset.tpl" identity_types=m.identity[id].all_types %}

<p>{_ Please click on the below link to verify your recent login _}</p>

<p><a href="{{ m.site.protocol }}://{{ m.site.hostname }}{% url login_verified uuid=uuid %}">{{ m.site.protocol }}://{{ m.site.hostname }}{% url login_verified uuid=uuid %}</a></p>

<p>{_ If you didn't login, you account might have been compromised. _}</p>
{% endblock %}

{% block disclaimer %}
<p style="color: #666; font-size: 80%;">--<br/>
{_ You have recieved this email because you have turned on Multi-Factor-Authentication. This will protect your account from getting hacked. _}</p>
{% endblock %}
