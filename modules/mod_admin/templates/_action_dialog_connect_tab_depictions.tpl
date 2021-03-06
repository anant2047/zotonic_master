<div class="tab-pane {% if is_active %}active{% endif %}" id="{{ tab }}-depiction">
	<p>{_ Select a connected image _}</p>

	<div id="dialog_connect_depictions" class="connect-results thumbnails">
		<div class="row">
            {% for id in m.rsc[subject_id].o.depiction %}
                {% catinclude "_action_dialog_connect_tab_find_results_item.tpl" id %}
            {% endfor %}
		</div>
	</div>
</div>

{% javascript %}
    $("#dialog_connect_depictions").on('click', '.thumbnail', function() {
        z_notify("admin-connect-select", { 
            z_delegate: "mod_admin", 
            select_id: $(this).data('id'),
            predicate: '{{ predicate }}',
            subject_id: '{{ subject_id }}',
            callback: '{{ callback }}',
            language: '{{ language }}'
        });
    });
{% endjavascript %}