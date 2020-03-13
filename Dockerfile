FROM archlinux

RUN pacman -q --noconfirm -Syu
RUN pacman -q --noconfirm -S  \
		base-devel    \
		curl          \
		expac         \
		git           \
		openssl       \
		yajl          \
                meson         \
                gtest         \
                gmock

RUN pacman -q --noconfirm -S vim ranger
RUN echo "Set disable_coredump false" > /etc/sudo.conf

RUN pacman -q --noconfirm -S perl fakeroot patch make cmake
RUN pacman -q --noconfirm -S jq

RUN sed -i '/NOPASSWD/s/\#//' /etc/sudoers
RUN useradd -r -g wheel build

WORKDIR /home/build
RUN chown -R build /home/build

RUN ln -s /usr/bin/core_perl/pod2man "/usr/bin/pod2man"

USER build
WORKDIR /home/build


RUN curl -s -o auracle.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/auracle-git.tar.gz && \
    tar -xvf auracle.tar.gz && \
    cd auracle-git && \
    makepkg --noconfirm && \
    sudo pacman --noconfirm -U *.tar.*

RUN curl -s -o pacaur.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz; \
    tar -xvf pacaur.tar.gz; \
    cd pacaur; \
    makepkg --noconfirm; \
    sudo pacman --noconfirm -U *.tar.*

