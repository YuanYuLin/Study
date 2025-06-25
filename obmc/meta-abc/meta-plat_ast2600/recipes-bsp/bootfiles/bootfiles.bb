DESCRIPTION = "Dummy"
LICENSE = "MIT"

inherit deploy nopackages

OUTPUT_DIR_NAME ?= "abc"
BOOTFILES_DIR_NAME ?= "bootfiles"

do_deploy() {
    install -d ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}
}

addtask deploy before do_build after do_install
do_deploy[dirs] += "${DEPLOYDIR}/${BOOTFILES_DIR_NAME}"
do_deploy[dirs] += "${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}"

