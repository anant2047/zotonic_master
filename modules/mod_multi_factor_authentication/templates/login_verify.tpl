{% if uuid %}

<h1 class="logon_header">{_ 2 Way Login Verification _}</h1>

    <p>{_ This is a valid link and should be redirected to login page. _}</p>
    
        <p><a class="btn btn-default" href="{% url logon %}">{_ Back to logon form _}</a></p>
        
{% else %}
<h1 class="logon_header">{_ 2 Way Login Verification _}</h1>

    <p>{_ This is an Invalid/Expired link. Please try again _}</p>
    
        <p><a class="btn btn-default" href="{% url logon %}">{_ Back to logon form _}</a></p>
    
{% endif %}
