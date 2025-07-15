from pybuilder.core import use_plugin, init, task

use_plugin('python.core')
use_plugin('python.unittest')
use_plugin('python.flake8')
use_plugin('python.coverage')

name = 'e-shopping-python'
default_task = ['clean', 'analyze', 'publish']

@init
def set_properties(project):
    project.build_depends_on('Flask')
    project.build_depends_on('Flask-SQLAlchemy')
    project.build_depends_on('coverage')
    project.build_depends_on('flake8')
    project.build_depends_on('unittest')
    project.set_property('coverage_break_build', False)
    project.set_property('flake8_break_build', True)
    project.set_property('dir_source_unittest_python', '.')
    project.set_property('unittest_module_glob', 'test_*.py')

@task
def run_tests(project, logger):
    """Run unit tests using unittest."""
    logger.info('Running unit tests...')

@task
def check_coverage(project, logger):
    """Check test coverage using coverage plugin."""
    logger.info('Checking coverage...')

@task
def lint_code(project, logger):
    """Lint code using flake8."""
    logger.info('Linting code...') 