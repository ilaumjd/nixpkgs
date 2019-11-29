{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wordpress";
  version = "5.3";

  src = fetchurl {
    url = "https://wordpress.org/${pname}-${version}.tar.gz";
    sha256 = "1aynx6i5qdlbfq1s9pik6xwk8zxx4rynv63jv52rlyk4gqgr37dj";
  };

  installPhase = ''
    mkdir -p $out/share/wordpress
    cp -r . $out/share/wordpress
  '';

  meta = with stdenv.lib; {
    homepage = "https://wordpress.org";
    description = "WordPress is open source software you can use to create a beautiful website, blog, or app";
    license = [ licenses.gpl2 ];
    maintainers = [ maintainers.basvandijk ];
    platforms = platforms.all;
  };
}
