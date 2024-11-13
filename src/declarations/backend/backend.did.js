export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'getCurrentNumber' : IDL.Func([], [IDL.Nat], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
