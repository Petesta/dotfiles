load.ivy("com.lihaoyi" %% "ammonite-shell" % ammonite.Constants.version)
load.ivy("com.chuusai" %% "shapeless" % "2.3.1")

@
val session = ammonite.shell.ShellSession()
import session._
import ammonite.ops._
ammonite.shell.Configure(repl, wd)
