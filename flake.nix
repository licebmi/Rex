{

  description = "Flake to install Rex";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      pname = "Rex";
      version = "a8520296d3a31a653ac76dd58c21819781346398";
    in flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = with pkgs.perlPackages; rec {

          AWSSignature4 = buildPerlModule {
            pname = "AWS-Signature4";
            version = "1.02";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/L/LD/LDS/AWS-Signature4-1.02.tar.gz";
              sha256 =
                "20bbc16cb3454fe5e8cf34fe61f1a91fe26c3f17e449ff665fcbbb92ab443ebd";
            };
            propagatedBuildInputs = [ LWP TimeDate URI ];
            meta = {
              description =
                "Create a version4 signature for Amazon Web Services";
              license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
            };
          };

          DistZillaPluginMetaProvides = buildPerlPackage {
            pname = "Dist-Zilla-Plugin-MetaProvides";
            version = "2.002004";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/K/KE/KENTNL/Dist-Zilla-Plugin-MetaProvides-2.002004.tar.gz";
              sha256 =
                "fc28142da9a44c3d0b4a819e422b654fb2c700c1e657d15b53aad39f22d07717";
            };
            buildInputs = [ PathTiny TestFatal ];
            propagatedBuildInputs = [
              TestDeep
              DistZilla
              HashMergeSimple
              Moose
              MooseXTypes
              namespaceautoclean
            ];
            meta = {
              homepage =
                "https://github.com/kentnl/Dist-Zilla-Plugin-MetaProvides";
              description =
                "Generating and Populating 'provides' in your META.yml";
              license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
            };
          };

          DistZillaPluginMakeMakerAwesome = buildPerlPackage {
            pname = "Dist-Zilla-Plugin-MakeMaker-Awesome";
            version = "0.49";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/E/ET/ETHER/Dist-Zilla-Plugin-MakeMaker-Awesome-0.49.tar.gz";
              sha256 =
                "1ff46df84886fcb9d00f53fe300d74bc7bac7b92023597e651c436d1824c030e";
            };
            buildInputs =
              [ CPANMetaCheck Filepushd ModuleBuildTiny TestDeep TestFatal ];
            propagatedBuildInputs =
              [ DistZilla Moose PathTiny TypeTiny namespaceautoclean ];
            meta = {
              homepage =
                "https://github.com/avar/dist-zilla-plugin-makemaker-awesome";
              description =
                "A more awesome MakeMaker plugin for L<Dist::Zilla>";
              license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
            };
          };

          DistZillaRoleModuleMetadata = buildPerlPackage {
            pname = "Dist-Zilla-Role-ModuleMetadata";
            version = "0.006";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/E/ET/ETHER/Dist-Zilla-Role-ModuleMetadata-0.006.tar.gz";
              sha256 =
                "5e211cbde5057b87f8e34061b662de4cee50373eb50ed5ecf2583e70a22ba21e";
            };
            buildInputs = [
              DistZilla
              ModuleBuildTiny
              PathTiny
              TestDeep
              TestFatal
              TestNeeds
            ];
            propagatedBuildInputs = [ Moose namespaceautoclean ];
            meta = {
              homepage =
                "https://github.com/karenetheridge/Dist-Zilla-Role-ModuleMetadata";
              description = "A role for plugins that use Module::Metadata";
              license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
            };
          };

          DistZillaPluginMetaProvidesPackage = buildPerlPackage {
            pname = "Dist-Zilla-Plugin-MetaProvides-Package";
            version = "2.004003";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/K/KE/KENTNL/Dist-Zilla-Plugin-MetaProvides-Package-2.004003.tar.gz";
              sha256 =
                "80bb21fd18aea9f5203674a8294e33221d39d37354b1791da237ff0911398585";
            };
            buildInputs = [ PathTiny TestFatal ];
            propagatedBuildInputs = [
              DataDump
              DistZilla
              DistZillaPluginMetaProvides
              DistZillaRoleModuleMetadata
              Moose
              MooseXLazyRequire
              MooseXTypes
              PPI
              SafeIsa
              namespaceautoclean
            ];
            meta = {
              homepage =
                "https://github.com/kentnl/Dist-Zilla-Plugin-MetaProvides-Package";
              description =
                "Extract namespaces/version from traditional packages for provides";
              license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
            };
          };

          DistZillaPluginOSPrereqs = buildPerlPackage {
            pname = "Dist-Zilla-Plugin-OSPrereqs";
            version = "0.011";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/D/DA/DAGOLDEN/Dist-Zilla-Plugin-OSPrereqs-0.011.tar.gz";
              sha256 =
                "06026cfd82c3f4fd9a5b75ae256a148d35ff5b977aabaf12cfcc6d73d823298f";
            };
            buildInputs = [ TestFatal TestDeep ];
            propagatedBuildInputs = [ DistZilla Moose namespaceautoclean ];
            meta = {
              homepage =
                "https://github.com/dagolden/Dist-Zilla-Plugin-OSPrereqs";
              description = "List prereqs conditional on operating system";
              license = pkgs.lib.licenses.asl20;
            };
          };

          DistZillaPluginOurPkgVersion = buildPerlPackage {
            pname = "Dist-Zilla-Plugin-OurPkgVersion";
            version = "0.21";
            src = pkgs.fetchurl {
              url =
                "mirror://cpan/authors/id/P/PL/PLICEASE/Dist-Zilla-Plugin-OurPkgVersion-0.21.tar.gz";
              sha256 =
                "76e3861f03f0ad87432089530349478f33dd07b56df650f8b971153c2e42d021";
            };
            buildInputs = [ TestDeep PathTiny TestException TestVersion ];
            propagatedBuildInputs =
              [ DistZilla Moose MooseXTypesPerl PPI namespaceautoclean ];
            meta = {
              homepage =
                "https://metacpan.org/dist/Dist-Zilla-Plugin-OurPkgVersion";
              description =
                "No line insertion and does Package version with our";
              license = pkgs.lib.licenses.artistic2;
            };
          };

          Rex = buildPerlPackage {
            inherit pname version;
            src = pkgs.fetchFromGitHub {
              owner = "Adjust";
              repo = "Rex";
              rev = "a8520296d3a31a653ac76dd58c21819781346398";
              sha256 = "y2bLIR4MchKmjy+ZYggrTuYwq1fSQzVEILL8GOJ7JQ0=";
            };
            postUnpack = ''
              trueRoot=$PWD
              cd $sourceRoot
              dzil build --in $trueRoot/dist --no-tgz
              sourceRoot=$trueRoot/dist'';
            buildInputs = [
              perl
              DistZilla
              DistZillaPluginMakeMakerAwesome
              DistZillaPluginMetaProvidesPackage
              DistZillaPluginOurPkgVersion
              DistZillaPluginOSPrereqs
              DistZillaPluginTestMinimumVersion
              DistZillaPluginTestPerlCritic
              FileShareDirInstall
              ParallelForkManager
              pkgs.shortenPerlShebang
              StringEscape
              TestDeep
              TestPod
              TestOutput
              TestUseAllModules
            ];
            propagatedBuildInputs = [
              AWSSignature4
              DataValidateIP
              DevelCaller
              DigestHMAC
              HTTPMessage
              HashMerge
              IOString
              IOTty
              JSONMaybeXS
              ListMoreUtils
              LWP
              NetOpenSSH
              NetSFTPForeign
              SortNaturally
              TermReadKey
              TextGlob
              URI
              XMLSimple
              YAML
            ];
            postInstall = pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
              shortenPerlShebang $out/bin/trex
              shortenPerlShebang $out/bin/trexify
            '';
            meta = {
              homepage = "https://www.rexify.org";
              description = "The friendly automation framework";
              license = pkgs.lib.licenses.asl20;
            };
          };
        };
        defaultPackage = self.packages.${system}.Rex;
        devShell = pkgs.mkShell {
          buildInputs = with pkgs.perlPackages; [
            pkgs.perl
            DistZilla
            self.packages.${system}.DistZillaPluginMakeMakerAwesome
            self.packages.${system}.DistZillaPluginMetaProvidesPackage
            self.packages.${system}.DistZillaPluginOurPkgVersion
            self.packages.${system}.DistZillaPluginOSPrereqs
            DistZillaPluginTestMinimumVersion
            DistZillaPluginTestPerlCritic
            FileShareDirInstall
            ParallelForkManager
            StringEscape
            TestDeep
            TestPod
            TestOutput
            TestUseAllModules
            self.packages.${system}.Rex
          ];
        };
      });

}
