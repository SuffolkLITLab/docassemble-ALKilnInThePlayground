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

- Added the constrained randomized test capabilities that GitHub-based tests already have. See [#41](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/41).
- Added ALKiln notifications to show information about updates, issues, and version conflicts between ALKiln and ALKilnInThePlayground. See [#49](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/49).
- Added offline capabilities. Authors and developers can now use ALKilnInThePlayground when they are offline. See [#46](https://github.com/SuffolkLITLab/docassemble-ALKilnInThePlayground/issues/46).
- Added shiny new interactions on output page:
   - Copy button for individual randomized files and console output
   - Buttons to jump to the bottom and top of the console output
   - Download buttons for individual randomized files and console output

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
