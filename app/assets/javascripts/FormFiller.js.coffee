window.FormFiller = class FormFiller
  constructor: ->
    @bindChange()

  bindChange: ->
    $('select').on 'change', @onListChange

  onListChange: (target) =>
    $target = $(event.target).find('option:selected')
    $('form').find('#movie_organization_permalink').val($target.data('organization-permalink'))
    $('form').find('#movie_project_name').val($target.data('project-name'))
    true