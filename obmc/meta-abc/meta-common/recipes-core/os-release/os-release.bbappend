def run_git(d, cmd):
    try:
        oeroot = d.getVar('COREBASE', True)

        git_branch = bb.process.run("git -C %s rev-parse --abbrev-ref HEAD" % (oeroot))[0].strip('\n')
        git_hash = bb.process.run("git -C %s rev-parse HEAD" % (oeroot))[0].strip('\n')
        return git_branch + "_" + git_hash[:6]
    except Exception as e:
        bb.warn("Unexpected exception from 'git' call: %s" % e)
        pass

PHOSPHOR_OS_RELEASE_DISTRO_VERSION := "${@run_git(d, '')}"
DISTRO_VERSION = "${PHOSPHOR_OS_RELEASE_DISTRO_VERSION}"
EXTENDED_VERSION = "${PHOSPHOR_OS_RELEASE_DISTRO_VERSION}"
