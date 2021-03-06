# This file is part of vimcom R package
# 
# It is distributed under the GNU General Public License.
# See the file ../LICENSE for details.
# 
# (c) 2011 Jakson Aquino: jalvesaq@gmail.com
# 
###############################################################

.onLoad <- function(libname, pkgname) {
    library.dynam("vimcom.plus", pkgname, libname, local = FALSE)

    if(is.null(getOption("vimcom.verbose")))
        options(vimcom.verbose = 0)

    if(is.null(getOption("vimcom.opendf")))
        options(vimcom.opendf = TRUE)

    if(is.null(getOption("vimcom.openlist")))
        options(vimcom.openlist = FALSE)

    if(is.null(getOption("vimcom.allnames")))
        options(vimcom.allnames = FALSE)

    if(is.null(getOption("vimcom.texerrs")))
        options(vimcom.texerrs = TRUE)

    if(is.null(getOption("vimcom.alwaysls")))
        options(vimcom.alwaysls = TRUE)

}

.onAttach <- function(libname, pkgname) {
    if(version$os == "mingw32")
        termenv <- "MinGW"
    else
        termenv <- Sys.getenv("TERM")

    if(interactive() && termenv != "" && termenv != "dumb" && Sys.getenv("VIMRPLUGIN_HOME") != ""){
        dir.create(paste0(Sys.getenv("VIMRPLUGIN_HOME"), "/r-plugin/objlist/"),
                   showWarnings = FALSE)
        .C("vimcom_Start",
           as.integer(getOption("vimcom.verbose")),
           as.integer(getOption("vimcom.opendf")),
           as.integer(getOption("vimcom.openlist")),
           as.integer(getOption("vimcom.allnames")),
           as.integer(getOption("vimcom.alwaysls")),
           PACKAGE="vimcom.plus")
    }
}

.onUnload <- function(libpath) {
    .C("vimcom_Stop", PACKAGE="vimcom.plus")
    Sys.sleep(1)
    library.dynam.unload("vimcom.plus", libpath)
}

