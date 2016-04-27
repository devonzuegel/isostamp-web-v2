class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, DocumentUploader

  # Background the storage of files to AWS & processing to speed up uploads
  store_in_background :attachment

  validates_presence_of %i(kind attachment user)
  enum kind: { 'Mass Spec Data': 0, 'Parameters': 1 }

  EXTENSION_WHITE_LIST = %w(mzXML txt)

  default_scope { order('created_at DESC') }

  scope :in_progress,    -> user { where(user: user).select { |d| !d.upload_complete? } }
  scope :done_uploading, -> user { where(user: user).select { |d|  d.upload_complete? } }

  validate :kind_matches_filetype

  def upload_complete?
    attachment_tmp.nil?
  end

  def filename
    File.basename(attachment.path || attachment_tmp || '')
  end

  private

  def kind_matches_filetype
    return if attachment.path.nil?

    ext = File.extname(attachment.path).sub('.', '')
    return if kind == filetype_to_kind_map[ext]

    expected_ext = filetype_to_kind_map.invert[kind]
    msg = "must have the .#{expected_ext} filetype. If you meant to upload " +
          "#{filetype_to_kind_map[ext].downcase}, please say so in the form."
    errors.add(:"#{kind}", msg)
  end

  def filetype_to_kind_map
    Hash[EXTENSION_WHITE_LIST.zip(self.class.kinds.keys)]
  end
end
