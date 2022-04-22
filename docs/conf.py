# Configuration file for the Sphinx documentation builder.
## https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------
import datetime
import os

# -- Helpers -----------------------------------------------------------------
VAULT_CONFLUENCE_USER_PATH = 'secret/devops/Jenkins/svc-ocf-jenkins'
def get_confluence_pass():
    password = None
    with os.popen(F'vault read -field=password {VAULT_CONFLUENCE_USER_PATH}') as input:
        password = input.read()

    return password

# -- Project information -----------------------------------------------------
project = 'Mostly Harmless'
this_year = datetime.date.today().year
copyright = F'2020-{this_year}, Cengage DevOps Team'
author = 'Cengage DevOps Team'

# -- General configuration ---------------------------------------------------
## Extensions
extensions = [
    'sphinx.ext.autodoc',
    'sphinx_rtd_theme',
    'myst_parser',
    'sphinxcontrib.confluencebuilder'
]

## MyST Config
myst_number_code_blocks = ['yaml']

## Confluence Config
# https://sphinxcontrib-confluencebuilder.readthedocs.io/en/stable/configuration/
confluence_publish = True
confluence_server_url = 'https://wiki.cengage.com/'
confluence_server_user = 'svc-ocf-jenkins'
confluence_server_pass = get_confluence_pass()
# confluence_ask_user = True
# confluence_ask_password = True
confluence_space_key = 'DEVOPS'
confluence_parent_page = 'Tsunami Reference Apps'
confluence_publish_prefix = 'MH/'
confluence_page_hierarchy = True
confluence_header_file = 'static/confluence-header.xml'

source_suffix = ['.rst', '.md']

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# -- Options for HTML output -------------------------------------------------
html_theme = 'sphinx_rtd_theme'

html_theme_options = {
    'style_nav_header_background': '#056F5F',
    'collapse_navigation': True,
}

html_static_path = ['static']
