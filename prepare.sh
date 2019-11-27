cd aeyrium_clock

flutter clean

cd ..

[ -e aeyrium_clock.zip ] && rm aeyrium_clock.zip

zip -r aeyrium_clock.zip flutter_clock_helper aeyrium_clock/assets aeyrium_clock/lib aeyrium_clock/test aeyrium_clock/.metadata aeyrium_clock/pubspec.yaml aeyrium_clock/README.md 
