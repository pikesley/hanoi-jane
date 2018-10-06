describe Hanoi::Jane do
  it 'has a version number' do
    expect(Hanoi::Jane::VERSION).not_to be nil
  end

  it 'scales a disc' do
    expect(Hanoi::Jane.scale 0).to eq 1
    expect(Hanoi::Jane.scale 1).to eq 3
    expect(Hanoi::Jane.scale 2).to eq 5
  end
end
