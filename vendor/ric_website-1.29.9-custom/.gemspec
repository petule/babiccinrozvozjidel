--- !ruby/object:Gem::Specification
name: ric_website
version: !ruby/object:Gem::Version
  version: 1.29.9
platform: ruby
authors:
- Matej Outly (Clockstar s.r.o.)
autorequire: 
bindir: bin
cert_chain: []
date: 2016-07-12 00:00:00.000000000 Z
dependencies:
- !ruby/object:Gem::Dependency
  name: rails
  requirement: !ruby/object:Gem::Requirement
    requirements:
    - - "~>"
      - !ruby/object:Gem::Version
        version: '4.2'
  type: :runtime
  prerelease: false
  version_requirements: !ruby/object:Gem::Requirement
    requirements:
    - - "~>"
      - !ruby/object:Gem::Version
        version: '4.2'
description: Pages structured in menu, text pages.
email:
- matej@clockstar.cz
executables: []
extensions: []
extra_rdoc_files: []
files:
- MIT-LICENSE
- README.rdoc
- Rakefile
- app/components/ric_website/breadcrumb_component.rb
- app/components/ric_website/description_component.rb
- app/components/ric_website/footer_menu_component.rb
- app/components/ric_website/languages_component.rb
- app/components/ric_website/menu_component.rb
- app/components/ric_website/sidemenu_component.rb
- app/components/ric_website/title_component.rb
- app/controllers/ric_website/admin_controller.rb
- app/controllers/ric_website/admin_menu_page_relations_controller.rb
- app/controllers/ric_website/admin_menus_controller.rb
- app/controllers/ric_website/admin_page_blocks_controller.rb
- app/controllers/ric_website/admin_page_menu_relations_controller.rb
- app/controllers/ric_website/admin_page_natures_controller.rb
- app/controllers/ric_website/admin_pages_controller.rb
- app/controllers/ric_website/admin_settings_controller.rb
- app/controllers/ric_website/admin_text_attachments_controller.rb
- app/controllers/ric_website/admin_texts_controller.rb
- app/controllers/ric_website/public_controller.rb
- app/controllers/ric_website/public_pages_controller.rb
- app/models/ric_website/menu.rb
- app/models/ric_website/page.rb
- app/models/ric_website/page_block.rb
- app/models/ric_website/setting.rb
- app/models/ric_website/settings_collection.rb
- app/models/ric_website/slug.rb
- app/models/ric_website/text.rb
- app/models/ric_website/text_attachment.rb
- app/views/components/ric_website/_breadcrumb.html.erb
- app/views/components/ric_website/_description.html.erb
- app/views/components/ric_website/_footer_menu.html.erb
- app/views/components/ric_website/_languages.html.erb
- app/views/components/ric_website/_menu.html.erb
- app/views/components/ric_website/_sidemenu.html.erb
- app/views/components/ric_website/_title.html.erb
- app/views/ric_website/admin_menu_page_relations/_related.html.erb
- app/views/ric_website/admin_menu_page_relations/edit.html.erb
- app/views/ric_website/admin_menus/_actions.html.erb
- app/views/ric_website/admin_menus/_form.html.erb
- app/views/ric_website/admin_menus/_related.html.erb
- app/views/ric_website/admin_menus/edit.html.erb
- app/views/ric_website/admin_menus/index.html.erb
- app/views/ric_website/admin_menus/new.html.erb
- app/views/ric_website/admin_menus/show.html.erb
- app/views/ric_website/admin_page_blocks/_actions.html.erb
- app/views/ric_website/admin_page_blocks/_form.html.erb
- app/views/ric_website/admin_page_blocks/_related.html.erb
- app/views/ric_website/admin_page_blocks/edit.html.erb
- app/views/ric_website/admin_page_blocks/new.html.erb
- app/views/ric_website/admin_page_blocks/show.html.erb
- app/views/ric_website/admin_page_menu_relations/_related.html.erb
- app/views/ric_website/admin_page_menu_relations/edit.html.erb
- app/views/ric_website/admin_pages/_actions.html.erb
- app/views/ric_website/admin_pages/_form.html.erb
- app/views/ric_website/admin_pages/_form_basic.html.erb
- app/views/ric_website/admin_pages/_form_basic_js.html.erb
- app/views/ric_website/admin_pages/_form_design.html.erb
- app/views/ric_website/admin_pages/_form_meta.html.erb
- app/views/ric_website/admin_pages/_related.html.erb
- app/views/ric_website/admin_pages/_show_basic.html.erb
- app/views/ric_website/admin_pages/_show_design.html.erb
- app/views/ric_website/admin_pages/_show_menus.html.erb
- app/views/ric_website/admin_pages/_show_meta.html.erb
- app/views/ric_website/admin_pages/_show_structure.html.erb
- app/views/ric_website/admin_pages/edit.html.erb
- app/views/ric_website/admin_pages/index.html.erb
- app/views/ric_website/admin_pages/new.html.erb
- app/views/ric_website/admin_pages/show.html.erb
- app/views/ric_website/admin_settings/_actions.html.erb
- app/views/ric_website/admin_settings/edit.html.erb
- app/views/ric_website/admin_settings/show.html.erb
- app/views/ric_website/admin_texts/_actions.html.erb
- app/views/ric_website/admin_texts/_form.html.erb
- app/views/ric_website/admin_texts/edit.html.erb
- app/views/ric_website/admin_texts/index.html.erb
- app/views/ric_website/admin_texts/new.html.erb
- app/views/ric_website/admin_texts/show.html.erb
- app/views/ric_website/public_pages/show.html.erb
- config/admin_routes.rb
- config/components/ric_website/breadcrumb_component.yml
- config/components/ric_website/footer_menu_component.yml
- config/components/ric_website/menu_component.yml
- config/components/ric_website/sidemenu_component.yml
- config/components/ric_website/title_component.yml
- config/locales/cs.yml
- config/models/ric_website/menu.yml
- config/models/ric_website/page.yml
- config/models/ric_website/page_block.yml
- config/models/ric_website/text.yml
- config/public_routes.rb
- config/routes.rb
- db/migrate/20150513110537_create_ric_website_texts.rb
- db/migrate/20150619081920_create_ric_website_menus.rb
- db/migrate/20150619081959_create_ric_website_pages.rb
- db/migrate/20150715133603_create_ric_website_text_attachments.rb
- db/migrate/20150721151036_create_ric_website_slugs.rb
- db/migrate/20151007084027_create_ric_website_settings.rb
- db/migrate/20151007085526_index_key_in_settings.rb
- db/migrate/20160128061454_create_ric_website_page_blocks.rb
- lib/ric_website.rb
- lib/ric_website/admin_engine.rb
- lib/ric_website/concerns/controllers/admin/menu_page_relations_controller.rb
- lib/ric_website/concerns/controllers/admin/menus_controller.rb
- lib/ric_website/concerns/controllers/admin/page_blocks_controller.rb
- lib/ric_website/concerns/controllers/admin/page_menu_relations_controller.rb
- lib/ric_website/concerns/controllers/admin/page_natures_controller.rb
- lib/ric_website/concerns/controllers/admin/pages_controller.rb
- lib/ric_website/concerns/controllers/admin/settings_controller.rb
- lib/ric_website/concerns/controllers/admin/text_attachments_controller.rb
- lib/ric_website/concerns/controllers/admin/texts_controller.rb
- lib/ric_website/concerns/controllers/public/pages_controller.rb
- lib/ric_website/concerns/models/menu.rb
- lib/ric_website/concerns/models/page.rb
- lib/ric_website/concerns/models/page_block.rb
- lib/ric_website/concerns/models/setting.rb
- lib/ric_website/concerns/models/settings_collection.rb
- lib/ric_website/concerns/models/slug.rb
- lib/ric_website/concerns/models/text.rb
- lib/ric_website/concerns/models/text_attachment.rb
- lib/ric_website/helpers/locale_helper.rb
- lib/ric_website/helpers/page_helper.rb
- lib/ric_website/helpers/setting_helper.rb
- lib/ric_website/helpers/slug_helper.rb
- lib/ric_website/middlewares/locale.rb
- lib/ric_website/middlewares/slug.rb
- lib/ric_website/public_engine.rb
- lib/ric_website/railtie.rb
- lib/tasks/ric_website_tasks.rake
homepage: http://www.clockstar.cz
licenses:
- MIT
metadata: {}
post_install_message: 
rdoc_options: []
require_paths:
- lib
required_ruby_version: !ruby/object:Gem::Requirement
  requirements:
  - - ">="
    - !ruby/object:Gem::Version
      version: '0'
required_rubygems_version: !ruby/object:Gem::Requirement
  requirements:
  - - ">="
    - !ruby/object:Gem::Version
      version: '0'
requirements: []
rubyforge_project: 
rubygems_version: 2.5.1
signing_key: 
specification_version: 4
summary: RIC engine for basic website management
test_files: []
