<img src="https://github.com/qirpi/arkive/blob/main/screenshot.png" width="800px"></img>

# Arkive: A private web archive

Arkive is a marriage of three ideas: __bookmarking__, __archiving to IA or similiar sites__ (mirroring) and __read-later__ services. (It also has annotations!)

All three have the same core purpose: saving stuff for later, yet go about it in very different ways, each with it's own strenghts and weaknesses. 

Let's look at the pros and cons of each:

* __Bookmarks__:
  - _Pros_: easy to save links to (always just a shortcut away), private, good organization capabiliites
  - _Cons_: linkrot (sites taken down..etc), sync problems
* __(Offsite) Archiving__:
  - _Pros_: protection from linkrot, backing up
  - _Cons_: public without option for private, no local copy (at the whim of provider)
* __Read-later__:
  - _Pros_: remembering interesting articles, marking as read, organization, removal of visual disturbances and ads
  - _Cons_: linkrot, at the whim of a third-party, not fully private

__Arkive is designed to solve all these problems at once — an archival / bookmarking / read-later system, that__:
  - __Protects you from linkrot__ by:
    - Auto-submitting links to the Internet Archive
    - Extracting readable content and saving it in database
  - __Easy and quick to submit links to__
    - Using the UI
    - Using the API: simply POST your url to `/`
      + This makes __one-tap save__ possible with e.g. HTTP Shortcuts on Android using the share menu
    - If no title is provided, it's fetched automatically
  - __Easy to read anywhere__ thanks to the responsive webui
  - Helps keeping track:
    - Has built in annotations on the extracted content
    - Articles can be marked as read and favorited
    - Displays reading time estimates
    - TODO articles can be put into collections
    - TODO shows you where you left off

### Installation / Dev environment setup (without Nix)
Make sure you have ruby 2.7.x then run

- Make sure you have installed:
  - ruby 2.7.x
  - bundler
  - nodejs 16.x
  - chromedriver
  - (optional) foreman or goreman for running the build servers
- cd into repo and run `bundle install`
- `gem install mailcatcher`
- goreman -f Procfile.dev start
  - or simply start `bin/rails server` and `bin/rails tailwindcss:watch` in separate terminals
- Arkive should be accessible on http://localhost:3000

### Installation / Dev env setup with Nix
- `./devenv.sh`

#### Versions

* Ruby: 2.7.6, Rails: 7.0.4

