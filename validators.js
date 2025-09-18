// validators.js
const allowedAvailability = ['В наличии', 'Под заказ', 'Нет в наличии'];
const allowedCategories = ['Памятники', 'Оформление', 'Благоустройство', 'Комплексы'];

function validateProductPayload(payload) {
  if (!payload.id || typeof payload.id !== 'string') return 'id required string';
  if (!payload.name || typeof payload.name !== 'string') return 'name required string';
  if (typeof payload.price !== 'number' && typeof payload.price !== 'string') return 'price required number';
  if (!payload.images || !Array.isArray(payload.images)) return 'images required array';
  if (!payload.availability || !allowedAvailability.includes(payload.availability)) return 'invalid availability';
  if (!payload.category || !allowedCategories.includes(payload.category)) return 'invalid category';
  if (!payload.features || !Array.isArray(payload.features)) return 'features required array';
  if (!payload.specifications || typeof payload.specifications !== 'object') return 'specifications required object';
  return null;
}

module.exports = { validateProductPayload, allowedCategories };
