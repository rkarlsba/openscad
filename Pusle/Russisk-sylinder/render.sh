#!/bin/bash
# vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
#
# Usage: openscad [options] file.scad {{{
# Allowed options:
#   --export-format arg               overrides format of exported scad file when
#                                     using option '-o', arg can be any of its 
#                                     supported file extensions.  For ascii stl 
#                                     export, specify 'asciistl', and for binary 
#                                     stl export, specify 'binstl'.  Ascii export
#                                     is the current stl default, but binary stl 
#                                     is planned as the future default so 
#                                     asciistl should be explicitly specified in 
#                                     scripts when needed.
#                                     
#   -o [ --o ] arg                    output specified file instead of running 
#                                     the GUI, the file extension specifies the 
#                                     type: stl, off, wrl, amf, 3mf, csg, dxf, 
#                                     svg, pdf, png, echo, ast, term, nef3, 
#                                     nefdbg (May be used multiple time for 
#                                     different exports). Use '-' for stdout
#                                     
#   -D [ --D ] arg                    var=val -pre-define variables
#   -p [ --p ] arg                    customizer parameter file
#   -P [ --P ] arg                    customizer parameter set
#   --enable arg                      enable experimental features (specify 'all'
#                                     for enabling all available features): 
#                                     fast-csg | fast-csg-trust-corefinement | 
#                                     fast-csg-debug | fast-csg-exact | 
#                                     fast-csg-exact-callbacks | fast-csg-remesh 
#                                     | fast-csg-remesh-predictibly | roof | 
#                                     input-driver-dbus | lazy-union | 
#                                     vertex-object-renderers | 
#                                     vertex-object-renderers-indexing | 
#                                     vertex-object-renderers-direct | 
#                                     vertex-object-renderers-prealloc | 
#                                     textmetrics | import-function | sort-stl
#                                     
#   -h [ --help ]                     print this help message and exit
#   -v [ --version ]                  print the version
#   --info                            print information about the build process
#                                     
#   --camera arg                      camera parameters when exporting png: 
#                                     =translate_x,y,z,rot_x,y,z,dist or 
#                                     =eye_x,y,z,center_x,y,z
#   --autocenter                      adjust camera to look at object's center
#   --viewall                         adjust camera to fit object
#   --imgsize arg                     =width,height of exported png
#   --render arg                      for full geometry evaluation when exporting
#                                     png
#   --preview arg                     [=throwntogether] -for ThrownTogether 
#                                     preview png
#   --animate arg                     export N animated frames
#   --view arg                        =view options: axes | crosshairs | edges | 
#                                     scales | wireframe
#   --projection arg                  =(o)rtho or (p)erspective when exporting 
#                                     png
#   --csglimit arg                    =n -stop rendering at n CSG elements when 
#                                     exporting png
#   --summary arg                     enable additional render summary and 
#                                     statistics: all | cache | time | camera | 
#                                     geometry | bounding-box | area
#   --summary-file arg                output summary information in JSON format 
#                                     to the given file, using '-' outputs to 
#                                     stdout
#   --colorscheme arg                 =colorscheme: *Cornfield | Metallic | 
#                                     Sunset | Starnight | BeforeDawn | Nature | 
#                                     DeepOcean | Solarized | Tomorrow | Tomorrow
#                                     Night | ClearSky | Monotone
#                                     
#   -d [ --d ] arg                    deps_file -generate a dependency file for 
#                                     make
#   -m [ --m ] arg                    make_cmd -runs make_cmd file if file is 
#                                     missing
#   -q [ --quiet ]                    quiet mode (don't print anything *except* 
#                                     errors)
#   --hardwarnings                    Stop on the first warning
#   --trace-depth arg                 =n, maximum number of trace messages
#   --trace-usermodule-parameters arg =true/false, configure the output of user 
#                                     module parameters in a trace
#   --check-parameters arg            =true/false, configure the parameter check 
#                                     for user modules and functions
#   --check-parameter-ranges arg      =true/false, configure the parameter range 
#                                     check for builtin modules
#   --debug arg                       special debug info - specify 'all' or a set
#                                     of source file names
#   -s [ --s ] arg                    stl_file deprecated, use -o
#   -x [ --x ] arg                    dxf_file deprecated, use -o
#
# }}}

for fn in $*
do
    nfn=$( echo $fn | sed s/\.scad$/\.stl/ )
    openscad -o $nfn $fn
    shift
done
