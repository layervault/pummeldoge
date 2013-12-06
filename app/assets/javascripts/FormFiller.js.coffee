window.FormFiller = class FormFiller
  constructor: ->
    @bindClicks()

  bindClicks: ->
    $('body').on 'click', 'li', @onListItemClick

  onListItemClick: (target) =>
    $target = $(event.target)
    $('form').find('#movie_organization_permalink').val($target.data('organization-permalink'))
    $('form').find('#movie_project_name').val($target.data('project-name'))
    true