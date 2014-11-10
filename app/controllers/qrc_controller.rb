class QrcController < ApplicationController
require 'rqrcode'
def index
	@qr = RQRCode::QRCode.new('Hello World')
end
def qrc
    @qr = RQRCode::QRCode.new('Test1')
end
end
