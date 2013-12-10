class PreviewGatheringService
  PREVIEW_OPTS = { w: Movie::WIDTH, h: Movie::HEIGHT }

  def initialize(user)
    @user = user
    @client = LayerVault::Client.new({ access_token: @user.access_token })
  end

  def thumbs(org_permalink=nil, project_name=nil)
    return @thumbs if @thumbs
    @thumbs = []

    unless org_permalink
      org_permalink = org_permalinks.last
    end

    projects = selected_organization(org_permalink)['projects']
    if project_name
      projects.select!{ |p| p['name'] == project_name }
    end

    projects.each do |project|
      @thumbs += descend_into_project(org_permalink, project['name'])
    end

    @thumbs
  end

  private

  def descend_into_project(org, project_name)
    to_return = []

    project = JSON.parse client.project(org, project_name)

    project['files'].each do |file|
      to_return += previews_from_file(org, project_name, '', File.basename(file['local_path']))
    end

    project['folders'].each do |folder|
      to_return += descend_into_folder(org, project_name, File.basename(folder['path']))
    end

    to_return
  end

  def descend_into_folder(org, project_name, folder_path)
    to_return = []

    folder = JSON.parse client.folder(org, project_name, folder_path)

    folder['files'].each do |file|
      to_return += previews_from_file(org, project_name, folder_path, file.name)
    end

    folder['folders'].each do |f|
      to_return += descend_into_folder(org, project_name, File.join(folder_path, File.basename(f.path)))
    end

    to_return
  end

  def previews_from_file(org, project, folder_path, file_name)
    begin
      JSON.parse client.previews(org, project, folder_path, file_name, PREVIEW_OPTS)
    rescue
      []
    end
  end

  def org_permalinks
    org_permalinks = me['organizations'].map{ |o| o['permalink'] }
  end

  def me
    JSON.parse client.me
  end

  def client
    @client
  end

  def selected_organization(org_permalink=nil)
    if org_permalink
      JSON.parse client.organization(org_permalink)
    else
      JSON.parse client.organization(org_permalinks.last)
    end
  end
end