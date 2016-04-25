class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader

  validates_presence_of :kind
  enum kind: { 'Mass Spec Data': 0, 'Parameters': 1 }

  EXTENSION_WHITE_LIST = %w(mzXML txt)
  FILETYPE_TO_KIND_MAP = Hash[EXTENSION_WHITE_LIST.zip(self.kinds.keys)]

  self.kinds.keys.zip(%w(.mzXML .txt)).to_h

  validate :kind_matches_filetype

  def filename
    File.basename(attachment.path || '')
  end

  private

  def kind_matches_filetype
    ext = File.extname(attachment.path).sub('.', '')
    return if kind == FILETYPE_TO_KIND_MAP[ext]

    expected_ext = FILETYPE_TO_KIND_MAP.invert[kind]
    msg = "must have the .#{expected_ext} filetype. If you meant to upload " +
          "#{FILETYPE_TO_KIND_MAP[ext].downcase}, please say so in the form."
    errors.add(:"#{kind}", msg)
  end
end
