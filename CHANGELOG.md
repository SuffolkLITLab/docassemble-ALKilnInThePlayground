# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- How to create a new entry:
See the documentation for Keep a Changelog above.
Try to keep them in this order if possible, skipping what you don't need:

Added - for new features.
Changed - for changes in existing functionality.
Deprecated - for soon-to-be removed features.
Removed - for now removed features.
Fixed - for any bug fixes.
Security - in case of vulnerabilities.

Format:

## [Unreleased]
-

## [1.0.0] - 2021-01-16
### Added
-

### Changed
-

### Deprecated
-

### Removed
-

### Fixed
-

### Security
-

### Internal
-
-->

## [Unreleased]

### Added
-

### Changed
- Change some errors to warnings
- Stop functional buttons from wrapping

### Deprecated
- Deprecating versions of ALKiln below 5.15.0 at this point.

### Fixed
- Fix "no scenario output" text was showing when there is indeed output. See [#66](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/66).
- Fix padding was missing from console output container (and other styles). Turns out we need the page to have `#daform` on it for some styles to take effect and that's one of them. Added `button` to that `show_output` to force it to have that id. It seems sub-optimal. See [#64](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/64).
- Fix generated file accordion items' box shadows are overlapped their previous siblings. That should close [#63](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/63) as well. See [#62](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/62).
- Fix make strings that should be f-strings into f-strings.
- Temporarily handle system error screen showing `TaskRevokedError: terminated`. Note: The system error disappeared when I added a linux `timeout` command and its argument to the start of the subprocess commands. I can't see how that additional command + argument could have made that screen, and possibly the error, disappear as `revoke` still gets triggered. With some manual testing, this does seem to be _a_ solution. We still need to explore how to really solve the revocation issues and I have some ideas. For now, the annoyance of the screen is gone. See [#68](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/68).

## [1.4.0] - 2025-10-26

### Added

- Added the constrained randomized test capabilities that GitHub-based tests already have. See [#41](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/41).
- Added ALKiln notifications to show information about updates, issues, and version conflicts between ALKiln and ALKilnInThePlayground. See [#49](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/49).
- Added offline capabilities. Authors and developers can now use ALKilnInThePlayground when they are offline. See [#46](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/46).
- Added shiny new interactions on output page:
   - Copy button for individual randomized files and console output
   - Buttons to jump to the bottom and top of the console output
   - Download buttons for individual randomized files and console output
- Allow author to skip the ALKiln version install screen to just run new tests
- Add metadata to the interview on the "My interviews" list page that includes the name of the Project and the tag expression. See [#49](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/59).
- Handles more types of errors
- Added the `alkip_debug` key to the known `alkiln` config options to allow an author to see more detailed logs from AKLilnInThePlayground itself.

### Changed
- Clarify interview language

### Fixed
- "Run new tests" button was deleting the current interview from the Interviews list

## [1.3.1] - 2024-02-25

### Added

- A maximum time for one test run. The default is 12 hours.
- Only minimally tested - a new config `alkiln` variable to customize the maximum time for one test run. Example:

```yml
alkiln:
  ALKILN_MAX_SECONDS_FOR_PLAYGROUND_TEST_RUN: 600
```

### Changed

- ALKiln errors now have codes that authors can give us to pinpoint the specific error

### Fixed

- All chrome processes should be closed, even when tests are ended early. It takes a minute. See [#38](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/38)
- Time elapsed for tests should now show the same/right time when the page is refreshed.

### Internal

- Added CHANGELOG.md
