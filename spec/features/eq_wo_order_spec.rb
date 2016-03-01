require_relative '../../lib/eq_wo_order'

describe '#eq_wo_order' do
  describe 'basic types' do
    describe 1 do
      it { is_expected.to eq_wo_order(1) }
      it { is_expected.not_to eq_wo_order(2) }
    end

    describe 'a' do
      it { is_expected.to eq_wo_order('a') }
      it { is_expected.not_to eq_wo_order('b') }
    end

    describe true do
      it { is_expected.to eq_wo_order(true) }
      it { is_expected.not_to eq_wo_order(false) }
    end
  end

  describe 'arrays' do
    describe ['a', 'b'] do
      it { is_expected.to eq_wo_order(['a', 'b']) }
      it { is_expected.to eq_wo_order(['b', 'a']) }
    end

    describe [1, 2] do
      it { is_expected.to eq_wo_order([1, 2]) }
      it { is_expected.to eq_wo_order([2, 1]) }
    end

    describe ['a', {b: 'c', d: 'e'}] do
      it { is_expected.to eq_wo_order([{d: 'e', b: 'c'}, 'a']) }
    end
  end

  describe 'hashes' do
    describe({a: 'b', c: 'd'}) do
      it { is_expected.to eq_wo_order({a: 'b', c: 'd'}) }
      it { is_expected.to eq_wo_order({c: 'd', a: 'b'}) }
    end

    describe({a: 1, b: 2}) do
      it { is_expected.to eq_wo_order({a: 1, b: 2}) }
      it { is_expected.to eq_wo_order({b: 2, a: 1}) }
    end
  end

  describe 'arrays of hashes' do
    describe [{a: 1}, {a: 2}] do
      it { is_expected.to eq_wo_order([{a: 2}, {a: 1}]) }
    end

    describe [{a: 1, b: 1}, {a: 1, b: 2}] do
      it { is_expected.to eq_wo_order([{a: 1, b: 2}, {a: 1, b: 1}]) }
      it { is_expected.not_to eq_wo_order([{a: 1, b: 1}, {a: 1, b: 2, c: 3}]) }
    end

    describe [{a: 1, b: 1}, {a: 1, b: 2, c: 3}] do
      it { is_expected.not_to eq_wo_order([{a: 1, b: 2}, {a: 1, b: 1}]) }
    end
  end

  describe 'arrays of arrays' do
    describe [[1, 2]] do
      it { is_expected.to eq_wo_order([[2, 1]]) }
      it { is_expected.not_to eq_wo_order([[2, 1, 3]]) }
    end

    describe [[1, 2, 3]] do
      it { is_expected.to eq_wo_order([[2, 1, 3]]) }
      it { is_expected.not_to eq_wo_order([[2, 1]]) }
    end

    describe [[[1, 2]]] do
      it { is_expected.to eq_wo_order([[[2, 1]]]) }
    end
  end

  describe 'hashes of hashes' do
    describe({a: {b: {c: 'd', e: 'f'}}}) do
      it { is_expected.to eq_wo_order({a: {b: {e: 'f', c: 'd'}}}) }
    end
  end

  describe 'hashes of arrays' do
    describe({a: [1, 2]}) do
      it { is_expected.to eq_wo_order({a: [2, 1]}) }
    end
  end

  describe 'deeply nested hashes and arrays' do
    describe [{a: [{b: 'c', d: 'e'}]}, {f: 5}, {g: 'h'}] do
      it { is_expected.to eq_wo_order([{f: 5}, {a: [{d: 'e', b: 'c'}]}, {g: 'h'}]) }
    end
  end
end