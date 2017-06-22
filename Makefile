BUILD_DIR=./build

.PHONY: build
build: clean
	mkdir -p $(BUILD_DIR)
	wget -P $(BUILD_DIR) https://github.com/runabove/beamium/archive/v$(VERSION).zip
	unzip -q -d $(BUILD_DIR) $(BUILD_DIR)/v$(VERSION).zip
	cd $(BUILD_DIR)/beamium-$(VERSION) && cargo build --release
	mv $(BUILD_DIR)/beamium-$(VERSION)/target/release/beamium $(BUILD_DIR)/

.PHONY: deb
deb:
		rm -f beamium*.deb
		fpm -m "<kevin@d33d33.fr>" \
		  --description "Prometheus to Warp10 metrics forwarder" \
			--url "https://github.com/runabove/beamium" \
			--license "BSD-3-Clause" \
			--version $(shell echo $$(./build/beamium --version | awk '{print $$2}')-$$(lsb_release  -cs)) \
			-n beamium \
			-d logrotate \
			-s dir -t deb \
			-a all \
			--deb-user beamium \
			--deb-group beamium \
			--deb-no-default-config-files \
			--config-files /etc/beamium/config.yaml \
			--deb-init deb/beamium.init \
			--directories /opt/beamium \
			--directories /var/log/beamium \
			--before-install deb/before-install.sh \
			--after-install deb/after-install.sh \
			--before-upgrade deb/before-upgrade.sh \
			--after-upgrade deb/after-upgrade.sh \
			--before-remove deb/before-remove.sh \
			--after-remove deb/after-remove.sh \
			--inputs deb/input

.PHONY: rpm
rpm:
		rm -f beamium*.rpm
		mkdir -p opt/beamium
		fpm -m "<kevin@d33d33.fr>" \
		  --description "Prometheus to Warp10 metrics forwarder" \
			--url "https://github.com/runabove/beamium" \
			--license "BSD-3-Clause" \
			--version $(shell echo $$(./build/beamium --version | awk '{print $$2}')) \
			-n beamium \
			-d logrotate \
			-s dir -t rpm \
			-a all \
			--rpm-user beamium \
			--rpm-group beamium \
			--config-files /etc/beamium/config.yaml \
			--rpm-init rpm/beamium.init \
			--before-install rpm/before-install.sh \
			--after-install rpm/after-install.sh \
			--before-upgrade rpm/before-upgrade.sh \
			--after-upgrade rpm/after-upgrade.sh \
			--before-remove rpm/before-remove.sh \
			--after-remove rpm/after-remove.sh \
			--inputs rpm/input \
			--rpm-auto-add-directories opt/beamium

.PHONY: clean
clean:
		rm -rf build
		rm -rf opt
