
# Get the List of post-receive_hooks
{% set hook_list = salt['pillar.get']('post-receive_hooks') %}

{% for hook in hook_list %}

  {% set hook_group = salt['pillar.get']('post-receive_hooks:' ~ hook ~ ':group', '') %}
  {% if hook_group %}

  post-receive_hook_{{ hook }}:
    file.managed:
      - name: {{ git_data }}{{ hook_group }}/{{ hook }}.git/custom_hook/post-receive
      - makedirs: True
      - user: root
      - group: root
      - file_mode: 754
      - contents_pillar: post-receive_hooks:{{ hook }}:file

  {% else %}
    Fail - no group in the post-receive_hooks [PILLAR Data]:
      test:
        A. fail_without_changes
  {% endif %}

{% endfor %}
=======
